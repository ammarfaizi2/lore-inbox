Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279936AbRJ3MOe>; Tue, 30 Oct 2001 07:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279938AbRJ3MOY>; Tue, 30 Oct 2001 07:14:24 -0500
Received: from dns.irisa.fr ([131.254.254.2]:55210 "HELO dns.irisa.fr")
	by vger.kernel.org with SMTP id <S279936AbRJ3MOP>;
	Tue, 30 Oct 2001 07:14:15 -0500
Date: Tue, 30 Oct 2001 13:14:51 +0100
From: DINH Viet Hoa <Viet-Hoa.Dinh@irisa.fr>
To: linux-kernel@vger.kernel.org
Subject: adding syscalls on linux
Message-Id: <20011030131451.78be5fc2.vdinh@irisa.fr>
Organization: IRISA
X-Mailer: Sylpheed version 0.6.4claws12 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When we want to give a the user mode access to a kernel function,
we have to write a syscall.

But in which case should we :
- add a syscall in the sys_call_table
- or add a device and add a fcntl identifier and handle this ?

thanks.

-- 
DINH Viêt Hoà, ingénieur associé, projet PARIS
IRISA-INRIA, Campus de Beaulieu, 35042 Rennes cedex, France
Tél: +33 (0) 2 99 84 75 98, Fax: +33 (0) 2 99 84 25 28
