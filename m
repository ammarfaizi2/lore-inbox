Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVI2ApO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVI2ApO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 20:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVI2ApN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 20:45:13 -0400
Received: from mail0.lsil.com ([147.145.40.20]:7926 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751289AbVI2ApM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 20:45:12 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57060CD1EB@exa-atlanta>
From: "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>
To: "'ray@madrabbit.org'" <ray@madrabbit.org>,
       "Bhattacharjee, Satadal" <Satadal.Bhattacharjee@engenio.com>,
       ray-lk@madrabbit.org
Cc: linux-kernel@vger.kernel.org,
       "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>,
       "Patro, Sumant" <Sumant.Patro@engenio.com>,
       "Ram, Hari" <hari.ram@engenio.com>,
       "Mukker, Atul" <Atul.Mukker@engenio.com>
Subject: RE: Registering for multiple SIGIO within a process
Date: Wed, 28 Sep 2005 20:44:44 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>(Sheesh, what is it with people thinking signals are something 
>to be used in any design after the 1970's?)
>

What's your recommendation for asynchronous notification from driver
to an application?
