Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265329AbUBAPTC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 10:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265333AbUBAPTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 10:19:02 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:57615 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265329AbUBAPS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 10:18:59 -0500
Date: Sun, 1 Feb 2004 16:18:46 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "Marcel J.E. Mol" <marcel@mesa.nl>
Cc: Andries Brouwer <aebr@win.tue.nl>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6 input drivers FAQ
Message-ID: <20040201161846.B28063@pclin040.win.tue.nl>
References: <20040201100644.GA2201@ucw.cz> <20040201141516.A28045@pclin040.win.tue.nl> <20040201135101.GA25794@joshua.mesa.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040201135101.GA25794@joshua.mesa.nl>; from marcel@mesa.nl on Sun, Feb 01, 2004 at 02:51:01PM +0100
X-Spam-DCC: Servercave: mailhost.tue.nl 1183; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 02:51:01PM +0100, Marcel J.E. Mol wrote:
> Andries,
> 
> ON Fedora development (around 30 jan)
> 
> % rpm -qf /usr/bin/setkeycodes
> kbd-1.08-12
> 
> % /usr/bin/setkeycodes e001 130
> setkeycode: code outside bounds

Yes. Try kbd-1.12.

