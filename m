Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWEBBmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWEBBmr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 21:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWEBBmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 21:42:47 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:23259 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932350AbWEBBmr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 21:42:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GKeGD+8r0xd2F/OWEcwv61tvGvxSLtJQbgEv5HSIodsi9YO6wg1FQmkq3BZAhiaeMwIeVC6nfLEyhTjl5mz0AyonaSTou+JR3daDzFALA3Wu4atDF6U1XZYOVaYrWwm2Wo6L04UnE0TKIjhYVpcg8McCAis9J+PKgX+bZddm44E=
Message-ID: <a6f9b16b0605011842l7f1f64ev420658bb8c4ac1f0@mail.gmail.com>
Date: Tue, 2 May 2006 09:42:46 +0800
From: "=?GB2312?B?zrrLpw==?=" <cpuwolf@gmail.com>
To: "linux kernel" <linux-kernel@vger.kernel.org>
Subject: frame buffer driver: xxx_setcolreg()
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sir,
I have some framebuffer driver problem in kernel2.6.14..
I have set fb_fix_screeninfo.visual = FB_VISUAL_TRUECOLOR,why I need
fb_var_screeninfo.pseudo_palette?
what is the use of xxx_setcolreg() function ?

thank you

Visual.Wei
