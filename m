Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318779AbSHRAZ4>; Sat, 17 Aug 2002 20:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318780AbSHRAZ4>; Sat, 17 Aug 2002 20:25:56 -0400
Received: from 209-221-203-149.dsl.qnet.com ([209.221.203.149]:54024 "HELO
	divino.rinspin.com") by vger.kernel.org with SMTP
	id <S318779AbSHRAZz>; Sat, 17 Aug 2002 20:25:55 -0400
Subject: Re: IDE?  IDE-TNG driver
From: Scott Bronson <bronson@rinspin.com>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208172353330.3111-100000@sharra.ivimey.org>
References: <Pine.LNX.4.44.0208172353330.3111-100000@sharra.ivimey.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 17 Aug 2002 17:28:38 -0700
Message-Id: <1029630519.1541.11.camel@emma>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-17 at 15:57, Ruth Ivimey-Cook wrote:
>  a) some people want basically module-less kernels

Everyone I've heard advocating a moduleless kernel uses an argument that
boils down to "it's slightly more secure."  Does anybody have a GOOD
reason for not using modules?  Obsolete or embedded hardware arguments
don't count.


>  b) in some environments, you need to be able to select the IO mechanism 
>     without the ability to select the module to load.

If that's the case, won't a kernel parameter suffice?  Can you
elaborate?

    - Scott



