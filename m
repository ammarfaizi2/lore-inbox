Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316893AbSEVIpS>; Wed, 22 May 2002 04:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316894AbSEVIpR>; Wed, 22 May 2002 04:45:17 -0400
Received: from newnetman.ebone.net ([195.158.227.238]:50818 "EHLO
	newnetman.ebone.net") by vger.kernel.org with ESMTP
	id <S316893AbSEVIpQ>; Wed, 22 May 2002 04:45:16 -0400
Message-ID: <3CEB5A9C.A3602DC2@maersk-moller.net>
Date: Wed, 22 May 2002 10:45:16 +0200
From: Peter Maersk-Moller <Peter@maersk-moller.net>
Organization: <http://www.maersk-moller.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: i2c-old.h missing in 2.5.15-2.5.16
In-Reply-To: <20020522083655Z316893-22651+48153@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Noticed that while trying to compile 2.5.15 and 2.5.16, then some of the drivers
(forgot which - maybe i2c-something it self) requires existence of linux/i2c-old.h,
but linux/i2c-old.h seems to have been excluded. Adding linux/i2c-old.h enables
a succesfull compiling of the kernel, but maybe it was left out intentionally.

--PMM
