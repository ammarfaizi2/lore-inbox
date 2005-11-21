Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbVKUSHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVKUSHH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 13:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVKUSHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 13:07:06 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:9114 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932441AbVKUSHC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 13:07:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=htPys4pL1JxZOZ+rfVjyg677IP71fCHiJiMhESe1qaAlM1eH8uWTLaYljL7OgXi+GBCqT2nV2EUXs1sRZaiWVSX73LUN8GTEPsR4vQCwqAeo8JjPaflGADYmKBBBhQGRf2kP+ELYz+B+w6YM/a6ocb7hOjo0ZNetYnLCRINhb7c=
Message-ID: <5ebee0d10511211006l4f5483ebg9a75cdedbffcaf9c@mail.gmail.com>
Date: Mon, 21 Nov 2005 13:06:58 -0500
From: Bill Jordan <woodennickel@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Proprietary Copyrights in the Kernel
In-Reply-To: <5E735516D527134997ABD465886BBDA61AC17E@USTR-EXCH5.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5E735516D527134997ABD465886BBDA61AC17E@USTR-EXCH5.na.uis.unisys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this out before, but it doesn't appear to have made the list.
Forgive me if I'm mistaken, and this is a repeat.

2 kernel files contain proprietary SGI copyright statements, and no
GPL copyright statement. The files are:

include/asm-ia64/sn/tioce.h
include/asm-ia64/sn/tioce_provider.h

These files (and copyrights) appeared somewhere after 2.6.13.

Bill Jordan
