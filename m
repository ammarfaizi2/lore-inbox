Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264244AbRF1USz>; Thu, 28 Jun 2001 16:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264238AbRF1USp>; Thu, 28 Jun 2001 16:18:45 -0400
Received: from boreas.isi.edu ([128.9.160.161]:38607 "EHLO boreas.isi.edu")
	by vger.kernel.org with ESMTP id <S264214AbRF1USe>;
	Thu, 28 Jun 2001 16:18:34 -0400
To: Dan Podeanu <pdan@spiral.extreme.ro>
cc: Miquel van Smoorenburg <miquels@cistron-office.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch. 
In-Reply-To: Your message of "Thu, 28 Jun 2001 22:09:46 +0300."
             <Pine.LNX.4.33L2.0106282206510.1123-100000@spiral.extreme.ro> 
Date: Thu, 28 Jun 2001 13:18:14 -0700
Message-ID: <21297.993759494@ISI.EDU>
From: Craig Milo Rogers <rogers@ISI.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Print all copyright, config, etc. as KERN_DEBUG.

	How about a new level, say "KERN_CONFIG", with a "show-config"
parameter to enable displaying KERN_CONFIG messages?

					Craig Milo Rogers
