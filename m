Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTK1NaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 08:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTK1NaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 08:30:06 -0500
Received: from [65.248.4.67] ([65.248.4.67]:18066 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S262196AbTK1NaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 08:30:04 -0500
Message-ID: <000701c3b5b3$addfbac0$34dfa7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: Question - non-exec stack 
Date: Fri, 28 Nov 2003 11:29:12 -0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I´d like to know  how non-exec stack can run on 32 bits processor. On 32bits
processor vm_exec and vm_read has the same flags . So your tasks will not
run very well.

att,
Breno Silva Pinto

