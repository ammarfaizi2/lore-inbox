Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWGLIsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWGLIsl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 04:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWGLIsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 04:48:41 -0400
Received: from mx1.cdacindia.com ([203.199.132.35]:19720 "HELO mx1.cdac.in")
	by vger.kernel.org with SMTP id S1750873AbWGLIsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 04:48:41 -0400
Date: Wed, 12 Jul 2006 14:18:36 +0530 (IST)
To: <linux-kernel@vger.kernel.org>
Subject: merging of two memory regions-HOWTO
From: "K.Mahesh" <maheshk@cdac.in>
X-Mailer: TWIG 2.8.3
Message-ID: <twig.1152694116.36325@cdac.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi all,

i have a problem with the following
in my driver, i have to allocate two physically contiguous chunks of 4MB
in kernel space and give it to hardware.

now i am trying for a  solution with which i can access those two chunks
as single chunk  in the kernel space

any help will be appreciated

plz CC me the responses.

thanks and regards,
K.Mahesh
