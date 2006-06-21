Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWFUT0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWFUT0J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWFUT0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:26:09 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:56487 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751289AbWFUT0I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:26:08 -0400
Message-ID: <44999D49.1060703@fr.ibm.com>
Date: Wed, 21 Jun 2006 21:26:01 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.17-mm1
References: <20060621034857.35cfe36f.akpm@osdl.org>	 <6bffcb0e0606210407y781b3d41nef533847f579520b@mail.gmail.com>	 <20060621041758.4235dbc6.akpm@osdl.org> <6bffcb0e0606210429t3e78e88dqd637718e4e22b3f0@mail.gmail.com> <44994F77.5030301@fr.ibm.com> <4499777C.7010505@zytor.com>
In-Reply-To: <4499777C.7010505@zytor.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

>> That's how i fixed it. Is that the right way to do it ?
> 
> Probably not.  I suspect what's needed is the same EXTRA_KLIBCCFLAGS as
> in socketcalls/Kbuild.

it works fine.

thanks !

C.
