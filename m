Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318627AbSHQBsN>; Fri, 16 Aug 2002 21:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318961AbSHQBsN>; Fri, 16 Aug 2002 21:48:13 -0400
Received: from amdext.amd.com ([139.95.251.1]:48116 "EHLO amdext.amd.com")
	by vger.kernel.org with ESMTP id <S318627AbSHQBsN>;
	Fri, 16 Aug 2002 21:48:13 -0400
From: harish.vasudeva@amd.com
X-Server-Uuid: 02753650-11b0-11d5-bbc5-00508bf987eb
Message-ID: <CB35231B9D59D311B18600508B0EDF2F04F285D0@caexmta9.amd.com>
To: linux-kernel@vger.kernel.org
Subject: need help with pci_module_init
Date: Fri, 16 Aug 2002 18:52:01 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 114373CF4972935-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi folks

 pci_module_init() works fine only the first time i load my driver. subsequent loads will fail with this call returning -19!! any clues?

thanx
HARISH V


