Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264407AbTDOIiQ (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 04:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264408AbTDOIiQ (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 04:38:16 -0400
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:26116 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264407AbTDOIiQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 04:38:16 -0400
Date: Tue, 15 Apr 2003 10:50:01 +0200 (CEST)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: Robert Love <rml@tech9.net>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][2.5 patch] K6-II/K6-II: enable X86_USE_3DNOW
In-Reply-To: <1050359780.3664.114.camel@localhost>
Message-ID: <Pine.LNX.4.51L.0304151049330.12930@piorun.ds.pg.gda.pl>
References: <20030414222110.GK9640@fs.tum.de> <1050359780.3664.114.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2003, Robert Love wrote:
> > Questions: Is it really correct to enable CONFIG_X86_USE_3DNOW?
> If you are right that the K6-2 and K6-3D support 3DNow!, then yes.

Yes, it does.

-- 
pozdr.  Pawe³ Go³aszewski        
---------------------------------
worth to see: http://www.againsttcpa.com/
CPU not found - software emulation...
