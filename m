Return-Path: <linux-kernel-owner+w=401wt.eu-S932840AbXAAU4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840AbXAAU4a (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 15:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932838AbXAAU4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 15:56:30 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:30047 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932840AbXAAU43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 15:56:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=i2gudX665WorfaEd0EiE0GGwdg1XiDKUzIXKlb4XuKBE4Ek/XGETHL/keLP83C4DUvhJxlGMJRb6wZ/vVFgY9ctKGZYr9vpuSHQ5mdAme43DP0gNozURgKJMN/n938prvmZ8HGOD17VqTLqk3+5um+EW7mmtAn4NVtOzkj3YTcI=
Subject: Cut power to a USB port?
From: Andrew Barr <andrew.james.barr@gmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 01 Jan 2007 15:56:25 -0500
Message-Id: <1167684985.28023.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a simple question perhaps someone can help me with here...

I have one of those simple LED keyboard lamps that get their power from
the USB port. Is there some way in Linux, using files under /sys I would
imagine, to cut power to the USB port into which this lamp is plugged? I
know I would have to manually figure out what port it's plugged into, as
it is not a "real" USB device...e.g. it just draws power. I would like
to be able to programmatically switch the lamp on and off.

Thanks in advance,
Andrew Barr

Please CC any replies

