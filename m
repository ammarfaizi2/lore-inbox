Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTIBCZq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 22:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTIBCZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 22:25:45 -0400
Received: from rxrelay.lga.net.sg ([203.92.84.247]:20410 "HELO
	rxrelay.lga.net.sg") by vger.kernel.org with SMTP id S263441AbTIBCZp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 22:25:45 -0400
Message-ID: <01C3713C.0DACA2E0.vanitha@agilis.st.com.sg>
From: Vanitha <vanitha@agilis.st.com.sg>
Reply-To: "vanitha@agilis.st.com.sg" <vanitha@agilis.st.com.sg>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Insert a Propreitary Encapsulation module to PPP
Date: Tue, 2 Sep 2003 10:22:03 +0800
Organization: Agilis
X-Mailer: Microsoft Internet E-mail/MAPI - 8.0.0.4211
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I want to insert a module which will add a proprietary encapsulation header
(specific to our systems) and then send out the ppp packet over serial
interface (it will either be a High speed serial interface or a V.35
interface).

How do i insert a module between ppp and hdlc modules ?. Are there any
documents
which tells more about using the Channel Interface in ppp ?

Do i need to emulate a tty for doing this ?


Thanks,
Vanitha
