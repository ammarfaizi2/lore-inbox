Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284356AbRLMQMk>; Thu, 13 Dec 2001 11:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284337AbRLMQMa>; Thu, 13 Dec 2001 11:12:30 -0500
Received: from t2.redhat.com ([199.183.24.243]:56814 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S284318AbRLMQMW>; Thu, 13 Dec 2001 11:12:22 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.GSO.4.30.0112131429040.16242-100000@balu> 
In-Reply-To: <Pine.GSO.4.30.0112131429040.16242-100000@balu> 
To: Pozsar Balazs <pozsy@sch.bme.hu>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: FBdev remains in unusable state 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Dec 2001 16:11:40 +0000
Message-ID: <12691.1008259900@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



pozsy@sch.bme.hu said:
>  Then why not include this set up code into vesafb? 

Because nobody's got round to porting it into the vesafb driver yet. And it 
may turn out to be prohibitively ugly if you do.

--
dwmw2


