Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbUBDU21 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUBDUZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:25:46 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:25607 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S266552AbUBDUZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:25:36 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
Date: Wed, 4 Feb 2004 23:06:10 +0300
To: linux-kernel@vger.kernel.org
Subject: IPV4 as module?
Message-ID: <20040204200610.GB3802@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any technical reaon IPV4 cannot be built as module? Current kernel
barely fits on floopy (even with IDE as module); factoring out IPV4
would allow to reduce size even more.

TIA

-andrey
