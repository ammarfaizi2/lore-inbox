Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293698AbSCFRTc>; Wed, 6 Mar 2002 12:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293712AbSCFRTW>; Wed, 6 Mar 2002 12:19:22 -0500
Received: from ns.suse.de ([213.95.15.193]:50438 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293704AbSCFRTU>;
	Wed, 6 Mar 2002 12:19:20 -0500
Date: Wed, 6 Mar 2002 18:19:18 +0100
From: Dave Jones <davej@suse.de>
To: Elias Dagher <edagher@ditrans.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make bzImage fails on ram disk code in 2.5.5
Message-ID: <20020306181918.C14098@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Elias Dagher <edagher@ditrans.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200203061703.MAA17490@agamemnon.cnchost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200203061703.MAA17490@agamemnon.cnchost.com>; from edagher@ditrans.com on Wed, Mar 06, 2002 at 09:00:25AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 09:00:25AM -0800, Elias Dagher wrote:
 > I am getting the following error when I do a make bzImage:
 > rd.c: In function `rd_make_request':
 > rd.c:271: too many arguments to function

 Delete the 2nd arg.

 > Can some one please tell me what the problem is so that I can correct it?  I 
 > want to use this kernel because of its new scheduler.

 This, and other problems fixed in 2.5.6pre2, and 2.5.5-dj.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
