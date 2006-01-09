Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWAIQc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWAIQc6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWAIQc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:32:57 -0500
Received: from ns.firmix.at ([62.141.48.66]:59104 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751204AbWAIQc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:32:56 -0500
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
	can't for a long time
From: Bernd Petrovitsch <bernd@firmix.at>
To: Boxer Gnome <aiko.sex@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <174467f50601082354y7ca871c7k@mail.gmail.com>
References: <174467f50601082354y7ca871c7k@mail.gmail.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 09 Jan 2006 17:32:49 +0100
Message-Id: <1136824369.5785.79.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 15:54 +0800, Boxer Gnome wrote:
> and the dos ntfs driver was not released by the MS offical.So,what' wrong?
> 
> Somebody who can explain this ?

The NTFS vendor is identical to the DOS vendor. Therefore it has access
to current, correct and complete documentation and can control and test
changes on dedicated test systems before bugs hits users seriously.
In case of filesystems (like here), "hitting the user seriously" means
"loosing the whole filesystem. Go and look for a recent backup.".

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

