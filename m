Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270868AbTGVPOD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 11:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270874AbTGVPOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 11:14:03 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:22797 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S270868AbTGVPOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 11:14:01 -0400
Date: Tue, 22 Jul 2003 17:29:03 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Japanese keyboards broken in 2.6
Message-ID: <20030722172903.A12240@pclin040.win.tue.nl>
References: <018401c35059$2bb8f940$4fee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <018401c35059$2bb8f940$4fee4ca5@DIAMONDLX60>; from ndiamond@wta.att.ne.jp on Tue, Jul 22, 2003 at 10:56:33PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 10:56:33PM +0900, Norman Diamond wrote:

> On a Japanese PS/2 keyboard

I did not read your long message but stopped after the above words.
Sorry if this is not an answer (ask again).

For 2.6.0t1 it helps to add the line

  keycode 183 = backslash bar

to your keymap.

