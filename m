Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283718AbRLDBak>; Mon, 3 Dec 2001 20:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282992AbRLDB3b>; Mon, 3 Dec 2001 20:29:31 -0500
Received: from ns.suse.de ([213.95.15.193]:58385 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281880AbRLDB2D>;
	Mon, 3 Dec 2001 20:28:03 -0500
Date: Tue, 4 Dec 2001 02:28:02 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Patrick E Kane <kane@urbana.css.mot.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bogus BogoMIPS on ThinkPad?  [Entertainment for Linus]
In-Reply-To: <200112040105.TAA16617@wrangler.urbana.css.mot.com>
Message-ID: <Pine.LNX.4.33.0112040225500.9778-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2001, Patrick E Kane wrote:

> When my ThinkPad 600E boots Linux says that it has a 75 MHz CPU,
> but my BIOS tells me it has a 300 MHz CPU -- whats the deal?

Try tpctl. (http://tpctl.sourceforge.net/)
Seems to have a 'SPeed' setting option.

(This is probably controllable from your BIOS too somewhere)

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs


