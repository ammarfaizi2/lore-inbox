Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263335AbTCNOLl>; Fri, 14 Mar 2003 09:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263336AbTCNOLk>; Fri, 14 Mar 2003 09:11:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28941 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263335AbTCNOLj>; Fri, 14 Mar 2003 09:11:39 -0500
Date: Fri, 14 Mar 2003 14:22:25 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Andries.Brouwer@cwi.nl
Cc: t_benk@web.de, linux-kernel@vger.kernel.org
Subject: Re: [util-linux] cfdisk bug?
Message-ID: <20030314142225.B23686@flint.arm.linux.org.uk>
Mail-Followup-To: Andries.Brouwer@cwi.nl, t_benk@web.de,
	linux-kernel@vger.kernel.org
References: <UTC200303141333.h2EDXL602770.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200303141333.h2EDXL602770.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Mar 14, 2003 at 02:33:21PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 02:33:21PM +0100, Andries.Brouwer@cwi.nl wrote:
> And maybe someone who knows about Acorns can add a test
> to make it less likely that an Acorn is recognized by accident.

Unfortunately, the checksum is all there is to positively identify
this partitioning scheme.  Yes, it's crap, but that's what happens
when there's a lack of direction from the top and people go off and
do their own partitioning schemes.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

