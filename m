Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315513AbSHBQj5>; Fri, 2 Aug 2002 12:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSHBQj5>; Fri, 2 Aug 2002 12:39:57 -0400
Received: from [209.184.141.189] ([209.184.141.189]:24943 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S315513AbSHBQjz>;
	Fri, 2 Aug 2002 12:39:55 -0400
Subject: Tigon3 support in 2.4.19-RC1 is odd.
From: Austin Gonyou <austin@digitalroadkill.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1028306594.8885.12.camel@UberGeek.coremetrics.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 02 Aug 2002 11:43:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Tx Bytes and Rx Bytes counters won't seem to go beyond 4gb. Has that
been fixed? TIA.
-- 
Austin Gonyou <austin@digitalroadkill.net>
