Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261864AbSIYAzp>; Tue, 24 Sep 2002 20:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261865AbSIYAzp>; Tue, 24 Sep 2002 20:55:45 -0400
Received: from mailf.telia.com ([194.22.194.25]:26603 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S261864AbSIYAzo>;
	Tue, 24 Sep 2002 20:55:44 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Adam Goldstein <Whitewlf@Whitewlf.net>, linux-kernel@vger.kernel.org
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
Date: Wed, 25 Sep 2002 02:59:12 +0200
User-Agent: KMail/1.4.7
Cc: Adam Taylor <iris@servercity.com>
References: <37EF12D6-D015-11D6-AD2E-000502C90EA3@Whitewlf.net>
In-Reply-To: <37EF12D6-D015-11D6-AD2E-000502C90EA3@Whitewlf.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200209250259.12810.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Asking some of the things I guess others will ask later, but I won't
look into this anymore this night.

Have you been able to determine if it is I/O bound or CPU bound?
Or maybe using to much CPU to do I/O?

Does anyone know what virtual memory system does Mandrake uses? 
 Linus, Andreas or Riels?
 Have you tried Mandrakes support?

vmstat	over some time would be nice to get a hint on what it is doing.
ext3		do you use the same journaling mode as on Moja?
top		how much CPU time does the kernel processes use?

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

