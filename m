Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261883AbSJDSRZ>; Fri, 4 Oct 2002 14:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261972AbSJDSRZ>; Fri, 4 Oct 2002 14:17:25 -0400
Received: from vger.timpanogas.org ([216.250.140.154]:54237 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S261883AbSJDSRY>; Fri, 4 Oct 2002 14:17:24 -0400
Date: Fri, 4 Oct 2002 12:15:43 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: 3DNOW Question/MMX Support in 2.4.X tree
Message-ID: <20021004121543.A29145@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I noticed that the MMX libraries seem tied to CYRIX and AMD builds 
in the config scripts.  I am wondering if MMX support for Intel 
is not supported in 2.4.X kernels except for these processor types.
The code appears to be usable on Intel.

Can someone clarify the MMX support for kernel code in the 
current 2.4.X trees and how extensive it is for Intel?

Thanks

Jeff

