Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVG2DAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVG2DAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 23:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVG2DAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 23:00:35 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:1814 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261897AbVG2DAd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 23:00:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FjjklCEb9t5QhFbZ+CJNG4mUpE6l9ZhQ4FnKCmAM5LVUbjTCSW2n9Z1J0x4QHQUi62KirMUZYI+kVBk0U3pe2vixk0CDhxoSPxjDkIWed9Hk8KTzrpTk2i9w/KQPIs09sFxVlRbBFaQtsXF/oIv+S4KJFCENhGxPjkSzGllEWSE=
Message-ID: <57861437050728195925a34ce1@mail.gmail.com>
Date: Thu, 28 Jul 2005 21:59:58 -0500
From: Jesus Delgado <jdelgado@gmail.com>
Reply-To: Jesus Delgado <jdelgado@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Not boot with kernel 2.6.13-rc4 in emachines
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

  Im try the tests with kernel 2.6.13-rc4, compile ok, boot when
reboot the system not boot,  try disable vga, acpi=off, etc, both not
boot any more.

 Use FC4, with kernel all series 2.6.12.xxx working and boot OK.

 Any idea?
