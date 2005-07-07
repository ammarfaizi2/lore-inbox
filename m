Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVGGFMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVGGFMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 01:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVGGFMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 01:12:23 -0400
Received: from mailgw1.technion.ac.il ([132.68.238.34]:13482 "EHLO
	mailgw1.technion.ac.il") by vger.kernel.org with ESMTP
	id S262179AbVGGFLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 01:11:41 -0400
Message-ID: <42CCB988.5010603@t2.technion.ac.il>
Date: Thu, 07 Jul 2005 08:11:36 +0300
From: Zvi Rackover <szvirack@t2.technion.ac.il>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: looking for GDT, LDT & IDT management code
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello all,

where can i find the code that initializes and the code that manages the 
following:
a) Global Descriptor Table (GDT)
b) Local Descriptor Table (LDT)
c) Interrupt Descriptor Table (IDT)
?

if anyone know of any good documentation/tutorial i would appriciate if 
you mentioned it/them.

yours,
Zvi
