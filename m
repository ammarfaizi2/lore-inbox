Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269222AbTGJLqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 07:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269223AbTGJLqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 07:46:21 -0400
Received: from mail.ithnet.com ([217.64.64.8]:15630 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S269222AbTGJLqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 07:46:20 -0400
Date: Thu, 10 Jul 2003 14:00:45 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: green@namesys.com, mason@suse.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
Message-Id: <20030710140045.5c0dc506.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.55L.0307091408340.26373@freak.distro.conectiva>
References: <20030706183453.74fbfaf2.skraw@ithnet.com>
	<1057515223.20904.1315.camel@tiny.suse.com>
	<20030709140138.141c3536.skraw@ithnet.com>
	<1057757764.26768.170.camel@tiny.suse.com>
	<20030709134837.GJ18307@namesys.com>
	<20030709141111.GK18307@namesys.com>
	<20030709162535.175d5fd3.skraw@ithnet.com>
	<Pine.LNX.4.55L.0307091408340.26373@freak.distro.conectiva>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jul 2003 14:18:37 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> Can you please revert them (with patch -R) and try to reproduce the
> problem?
> 
> Thanks

In addition I can tell you that the problem is also visible with -pre4

Regards,
Stephan
