Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbUBKALL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 19:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUBKALL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 19:11:11 -0500
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:13473 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263486AbUBKALK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 19:11:10 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch] Re: psmouse.c, throwing 3 bytes away
Date: Tue, 10 Feb 2004 21:11:13 +0000
User-Agent: KMail/1.6
References: <200402041820.39742.wnelsonjr@comcast.net> <200402070911.42569.murilo_pontes@yahoo.com.br> <20040209004812.GA18512@ucw.cz>
In-Reply-To: <20040209004812.GA18512@ucw.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402102111.13931.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, 
I tested by 12hours, everything is ok :)
But I want test more few days


Em Seg 09 Fev 2004 00:48, você escreveu:
> On Sat, Feb 07, 2004 at 09:11:42AM +0000, Murilo Pontes wrote:
> 
> > Problem still occurs :-(
> 
> And here is a fix. Damn stupid mistake I made.
> 
