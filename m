Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266411AbSKZQw2>; Tue, 26 Nov 2002 11:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266417AbSKZQw2>; Tue, 26 Nov 2002 11:52:28 -0500
Received: from web40806.mail.yahoo.com ([66.218.78.183]:7842 "HELO
	web40806.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266411AbSKZQw2>; Tue, 26 Nov 2002 11:52:28 -0500
Message-ID: <20021126165938.25215.qmail@web40806.mail.yahoo.com>
Date: Tue, 26 Nov 2002 17:59:38 +0100 (CET)
From: =?iso-8859-1?q?bastien=20roucaries?= <montagnard83@yahoo.fr>
Subject: Specific fs flags access accross xattr calls 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I write a little patch that enable read and write 
of specific msdos attrs ( hidden , system , archive )
accross xattr call.

I think it s a good idea but I need your opinion.

Indeed:

    - This can


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
