Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbSAUNuk>; Mon, 21 Jan 2002 08:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286462AbSAUNuU>; Mon, 21 Jan 2002 08:50:20 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:13736 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S285720AbSAUNuQ>; Mon, 21 Jan 2002 08:50:16 -0500
Message-ID: <3C4C1C96.9330C916@redhat.com>
Date: Mon, 21 Jan 2002 13:50:14 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon PSE/AGP Bug
In-Reply-To: <1011610422.13864.24.camel@zeus> <20020121.053724.124970557.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:

> The funny part is, if this published errata is the problem, it cannot
> be a problem under Linux since we never invalidate 4MB pages.  We
> create them at boot time and they never change after that.

Well we don't know what nvidia's kernel module is doing.....
