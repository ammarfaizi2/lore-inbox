Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbTIDLeK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 07:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbTIDLeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 07:34:09 -0400
Received: from alfarrabio.di.uminho.pt ([193.136.20.210]:40108 "HELO
	alfarrabio.di.uminho.pt") by vger.kernel.org with SMTP
	id S264918AbTIDLeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 07:34:07 -0400
Subject: How to debug ACPI?
From: Alberto Manuel =?ISO-8859-1?Q?Brand=E3o_Sim=F5es?= 
	<albie@alfarrabio.di.uminho.pt>
Reply-To: albie@alfarrabio.di.uminho.pt
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-15
Organization: Departamento de  =?ISO-8859-1?Q?=20Inform=C3=A1tica?= - Universidade do Minho
Message-Id: <1062675563.7371.8.camel@eremita.di.uminho.pt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 04 Sep 2003 12:39:23 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have a Laptop (Clevo is its brand) which has ACPI (I don't know if he
follow the standards).

With some kernels before I was able to see a /proc/acpi directory with
some information (most of them wrong, but ok) and I was able to shutdown
the laptop properly.

With kernel 2.4.22 the /proc/acpi directory does not exist (but I've
compiled it) and modules ac.o, battery.o and so on give a 'init_module:
No such device' answer.

I need to make it turn off automatically again, at least. I know I can
use my last kernel, but it is not quite a good idea, as I would like to
continue updating my kernel.

Thanks for any help 
(please cc me in reply, as I'm not a member of the list)
Alberto Simões
-- 
Alberto Manuel Brandão Simões <albie@alfarrabio.di.uminho.pt>
Departamento de Informática - Universidade do Minho

