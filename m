Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271606AbRHPScs>; Thu, 16 Aug 2001 14:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271607AbRHPSci>; Thu, 16 Aug 2001 14:32:38 -0400
Received: from canudos.ufba.br ([200.18.228.128]:33745 "EHLO canudos.ufba.br")
	by vger.kernel.org with ESMTP id <S271606AbRHPScY> convert rfc822-to-8bit;
	Thu, 16 Aug 2001 14:32:24 -0400
Message-Id: <1.5.4.32.20010816183836.0093c574@ufba.br>
X-Mailer: Windows Eudora Light Version 1.5.4 (32)
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Thu, 16 Aug 2001 15:38:36 -0300
To: linux-kernel@vger.kernel.org
From: Mercia Eliane Bittencourt Figueredo <mercia@ufba.br>
Subject: multicast problem in kernel 2.4.7-ac11 ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I´m trying to use the Multicast IP in linux-2.4.7-ac11 but it doesnot work...
I already added IP Multicasting in the kernel and I configured the route :
route add -net 224.0.0.0 netmask 240.0.0.0 dev atm0.
The error message is "setsockopt - IP_ADD_MEMBERSHIP: No such device".
Could You help me?
Thanks.
Mercia




