Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbUL3QHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbUL3QHQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 11:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbUL3QHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 11:07:16 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:54356 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261662AbUL3QHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 11:07:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=YaP1mPpBE4tgajrftDxiphVnF9+vtefJ1nOeTpa4r/euQH9AKRfen/dBbYY6QzysQy6/yrbKg8S0mC/wKXKWNDdb4z2gU4Q+IyYp5J+Sj3TwXTq4JUyBdYY00ImemRVJy3cWkgxkNb8En28bOXthttVxNpHKbBxOfFvmZ/IZHEE=
Message-ID: <105c793f041230080734d71c4a@mail.gmail.com>
Date: Thu, 30 Dec 2004 11:07:06 -0500
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: hps@intermeta.de
Subject: Re: Fwd: Toshiba PS/2 touchpad on 2.6.X not working along bottom and right sides
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cr16ho$eh1$1@tangens.hometree.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <105c793f04122907116b571ebf@mail.gmail.com>
	 <105c793f041230065818ba608f@mail.gmail.com>
	 <cr16ho$eh1$1@tangens.hometree.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004 15:23:36 +0000 (UTC), Henning P. Schmiedehausen
<hps@intermeta.de> wrote:
> This might be a touchpad that simulates the scroll wheel on the right
> side and horizontal scrolling on the bottom.
> 
> Does your touchpad emit mouse button events when touching on the
> right / bottom side?
> 
> I have a Toshiba Satellite with another touchpad (a Synaptics) and
> this can be programmed to do so. I'd think that Toshiba noadays uses
> touchpads that have this hard-coded (maybe there is a command to turn
> this on/off).
I have a ThinkPad T42 that can do this, as well, and this is what I
thought when I first encountered this problem. However, I've had this
Gateway laptop since about 1999 and it hasn't done this since. Not in
2.2 or 2.4.

Also, like I said, xev produced no output when I touched and dragged
in the offending areas.

If this really is an added feature and there's a way to turn it off,
that would be okay. Having it off by default would be best since it's
seemingly a changed behavior between one kernel version and another
(also, I hate that feature :) ).

--
Andy
