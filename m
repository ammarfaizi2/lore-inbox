Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWEBCzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWEBCzQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 22:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWEBCzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 22:55:15 -0400
Received: from pproxy.gmail.com ([64.233.166.180]:30045 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932356AbWEBCzO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 22:55:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qnkqiLmnLwk60IOaEgS2tmDEiReAMZmc00DPe9/eo6AH/pCIQ72/IjALP8LUWN0wdDFYqkd9rra2UEWGJdWvlqCy1fYLaTDL4VdhxXGwC3NXfE2ubYQuxPV5t6370mwbQpswv2YRY71i8mnBOs+TJekMvZJxbFIUZRGMfKZ/Few=
Message-ID: <a6f9b16b0605011955t4ade42bbi8c12a741463a8996@mail.gmail.com>
Date: Mon, 1 May 2006 19:55:13 -0700
From: "=?GB2312?B?zrrLpw==?=" <cpuwolf@gmail.com>
To: "linux kernel" <linux-kernel@vger.kernel.org>
Subject: frame buffer driver
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear ,
    I have written a framebuffer driver for my OMAP850 platform LCD
controller.linux logo and kernel debug message can show now.But screen
is "shaking".Just like,for every pixel,black and white,black and
white........at high frequency.Is there any kernel thread refresh
console?? Or I have some error in my driver?
   Thank you
