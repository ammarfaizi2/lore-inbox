Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286550AbRLUUpR>; Fri, 21 Dec 2001 15:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286553AbRLUUpI>; Fri, 21 Dec 2001 15:45:08 -0500
Received: from pop.gmx.de ([213.165.64.20]:47471 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S286550AbRLUUo6>;
	Fri, 21 Dec 2001 15:44:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Christian Armingeon <linux.johnny@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: link errors with CONFIG_SERIAL_ACPI enabled
Date: Fri, 21 Dec 2001 22:45:07 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011221204458Z286550-18284+5821@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
I noticed, that every time I switch on CONFIG_SERIAL_ACPI as a Module, I get some linker errors when make bzImage tries to link the bzImage together.
I don't have the exact output at hands, but I'll reproduce it if needed.

Johnny
