Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265555AbSJSIhg>; Sat, 19 Oct 2002 04:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265556AbSJSIhg>; Sat, 19 Oct 2002 04:37:36 -0400
Received: from 19.2.237.216.globalpac.com ([216.237.2.19]:23782 "HELO
	mail.tuluc.com") by vger.kernel.org with SMTP id <S265555AbSJSIhf>;
	Sat, 19 Oct 2002 04:37:35 -0400
Message-ID: <33182.24.130.42.133.1035014240.squirrel@mail.tuluc.com>
Date: Sat, 19 Oct 2002 00:57:20 -0700 (PDT)
Subject: 2.5.44 compilation errors
From: <haoviet@tuluc.com>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso_8859_1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--------------------------------------------------------------------------
drivers/scsi/qla1280.c:5932: unknown field `next' specified in initializer
drivers/scsi/qla1280.c:5932: warning: missing braces around initializer
drivers/scsi/qla1280.c:5932: warning: (near initialization for
`driver_template.shtp_list')make[2]: *** [drivers/scsi/qla1280.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2
----------------------------------------------------------------------------



