Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTKVRgU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 12:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTKVRgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 12:36:20 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:8 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262566AbTKVRgT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 12:36:19 -0500
Date: Sat, 22 Nov 2003 18:36:17 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: marcelo@cyclades.com, linux-kernel@vger.kernel.org,
       sensors@Stimpy.netroedge.com
Subject: Re: [PATCH 2.4] Trivial changes to I2C stuff
Message-Id: <20031122183617.18149a3d.khali@linux-fr.org>
In-Reply-To: <20031122164907.GA3121@kroah.com>
References: <20031122161510.7d5b4d20.khali@linux-fr.org>
	<20031122164907.GA3121@kroah.com>
Reply-To: sensors@stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Woah, -rc3 is _way_ too late for patches such as this.

"Patches like this"? A patch could hardly do less (real) things than
this one. What's the problem? I thought -rc were a perfect place for
these kind of cleanup changes.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
