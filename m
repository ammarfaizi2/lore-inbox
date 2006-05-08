Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWEHPPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWEHPPd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 11:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWEHPPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 11:15:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19422 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932355AbWEHPPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 11:15:32 -0400
Subject: Re: How to read BIOS information
From: Arjan van de Ven <arjan@infradead.org>
To: Madhukar Mythri <madhukar.mythri@wipro.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <445F5DF1.3020606@wipro.com>
References: <445F5228.7060006@wipro.com>
	 <1147099994.2888.32.camel@laptopd505.fenrus.org>
	 <445F5DF1.3020606@wipro.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 17:15:28 +0200
Message-Id: <1147101329.2888.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 20:34 +0530, Madhukar Mythri wrote:
> 
> >
> "proc/cpuinfo" says only HT support is their or not but, it will not
> say 
> whether HT is Enalbled/Disabled..

no I didn't mean the cpu flags line, but the "sibblings" line. If that
says "2" then HT is enabled ;)


