Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277034AbRJHR4K>; Mon, 8 Oct 2001 13:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277044AbRJHRzu>; Mon, 8 Oct 2001 13:55:50 -0400
Received: from ssh-yyz.somanetworks.com ([216.126.67.45]:14690 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S277034AbRJHRzr>; Mon, 8 Oct 2001 13:55:47 -0400
Subject: Re: [RFC] Standard way of generating assembler offsets
From: Georg Nikodym <georgn@somanetworks.com>
To: george anzinger <george@mvista.com>
Cc: Pantelis Antoniou <panto@intracom.gr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3BC1E294.1A4FB12D@mvista.com>
In-Reply-To: <28136.1002196028@ocs3.intra.ocs.com.au>
	<3BC1735F.41CBF5C1@intracom.gr>  <3BC1E294.1A4FB12D@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 08 Oct 2001 13:56:11 -0400
Message-Id: <1002563771.21079.3.camel@keller>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At the risk of sticking my foot in it, is there something wrong with the
ANSI C offsetof() macro, defined in <stddef.h>?

--Georg

