Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSEHSff>; Wed, 8 May 2002 14:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314872AbSEHSfe>; Wed, 8 May 2002 14:35:34 -0400
Received: from chuleta.newphoenixsrl.com ([200.49.68.228]:28677 "EHLO
	chuleta.newphoenixsrl.com") by vger.kernel.org with ESMTP
	id <S314835AbSEHSfd>; Wed, 8 May 2002 14:35:33 -0400
Date: Wed, 8 May 2002 15:31:03 -0300
From: Santiago Nullo <sn@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: ACPI and swsusp in 2.4.19pre8-ac1
Message-Id: <20020508153103.7df44508.sn@softhome.net>
Organization: Newphoenix SRL
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's an ACPI patch for 2.4.18 wich is newer and (in my personall experience) better than the acpi code currently used on the 2.4.19preX-acX series. Is there a reason for keep this code instead of integrate the new code? Is swsusp one of them?


