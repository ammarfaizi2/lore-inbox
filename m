Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132879AbRDEMc6>; Thu, 5 Apr 2001 08:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132880AbRDEMct>; Thu, 5 Apr 2001 08:32:49 -0400
Received: from t2.redhat.com ([199.183.24.243]:7416 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132878AbRDEMc3>; Thu, 5 Apr 2001 08:32:29 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010405150219.B873@mea-ext.zmailer.org> 
In-Reply-To: <20010405150219.B873@mea-ext.zmailer.org>  <Pine.LNX.4.21.0104051930580.2687-100000@pcc65.sasi.com> <Pine.LNX.4.30.0104050732080.13246-100000@localhost> 
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Bart Trojanowski <bart@jukie.net>, Manoj Sontakke <manojs@sasken.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: which gcc version? 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Date: Thu, 05 Apr 2001 13:26:32 +0100
Message-ID: <25567.986473592@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


matti.aarnio@zmailer.org said:
> 	To think of it, there really should be explicitely callable
> 	versions of these with LinuxKernel names for them, not gcc
> 	builtins.   That way people would *know* they are doing
> 	something, which is potentially very slow.
> 	(And the API would not change from underneath them.) 

Like include/asm-*/div64.h::do_div()?

--
dwmw2


