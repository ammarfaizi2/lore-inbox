Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVGYLDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVGYLDM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 07:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVGYLDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 07:03:12 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:29571 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261223AbVGYLDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 07:03:11 -0400
Message-ID: <42E4C6E7.4060806@namesys.com>
Date: Mon, 25 Jul 2005 15:03:03 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: msmulders@pronexus.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: help! kernel errors?
References: <20050725115015.zo345iawcqw0gws0@intranet.pronexus.loc>
In-Reply-To: <20050725115015.zo345iawcqw0gws0@intranet.pronexus.loc>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

msmulders@pronexus.nl wrote:
> Hello,
> 
> I'm getting loads and loads of kernel errors in my syslog, but am unable to
> decipher them into anything meaningful. 
You may want to take a look at linux/Documentation/oops-tracing.txt

> It occurs during a backup procedure and
> looking at the error it's got something to do with process 'rsync' but I haven't
> got a clue what's going wrong here (hardware? drivers? modules? kernel? what?).
> I'm hoping you guys can help me out. The repeating error is attached below!
> 
