Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264063AbTFDVEV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264075AbTFDVEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:04:21 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:53441 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264063AbTFDVEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:04:21 -0400
Message-Id: <5.1.0.14.2.20030604223233.00af9ac0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 04 Jun 2003 23:17:53 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: I2C/Sensors 2.5.70
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: Xjgb7UZ6wevYEOau0kUdCD-8FMmj-dWZUxLtPKBSeu9Z4swA24INk5@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Check at the bottom of this page:
Indeed (kicks self).
So,  to test a new external driver, I have to select an existing one.
Seems a bit restrictive.
I think it should be selectable in I2C (builtin/module) and cross-checked
in sensors.


Margit

