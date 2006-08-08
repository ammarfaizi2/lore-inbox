Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWHHKGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWHHKGz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWHHKGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:06:55 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:6739 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932164AbWHHKGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:06:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kpDWjcEDgoS98vyvEfcWLCX+yfwZlRF0cXzTgZfUzhZeKshB1Nonp37PXPmITqaFDjKPxdsKt8o8AFTTEO1GpNtrmpOFElS8SSceOcO0IgHu0TZd+fjAAjDOmSkTFySvknq5IBy+qZC9YrzfmHbZ+hqmhJeNnQsn24NbcUygVHs=
Message-ID: <7cd5d4b40608080306i7b9a7355y192c9272b3f0a6c1@mail.gmail.com>
Date: Tue, 8 Aug 2006 18:06:52 +0800
From: "jeff shia" <tshxiayu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: when I use date command to change the date of the system, will it infuence the other process
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I use date command to change the date of the system.
if at that time  I have a process  running to a sleep(),
Does it influence the process?
Thank you in advance!

Chris
