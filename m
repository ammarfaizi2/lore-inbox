Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135793AbRDZR21>; Thu, 26 Apr 2001 13:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135738AbRDZR2S>; Thu, 26 Apr 2001 13:28:18 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:29710 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S135766AbRDZR2L>; Thu, 26 Apr 2001 13:28:11 -0400
Date: Thu, 26 Apr 2001 19:28:09 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [2.4.4pre6] build failure
Message-ID: <20010426192809.A18660@maggie.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.4pre6 breaks build on gcc 2.95.2/gnu ld 2.9.5 for x86 with undefined
__builtin_expect reference when linking for bzImage. Details have been
discussed dome days ago for some 2.4.3-ac version.

-- 
Matthias Andree
