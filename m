Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWJVUpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWJVUpY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 16:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWJVUpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 16:45:23 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:33 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751447AbWJVUpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 16:45:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tX3f68d4ih+ykmMEo5dgkMTyLo6O/4SU3gyFbtmuAJnkTIF5VMGyA3DnKW5LGH9asozNUjGM36502fZfg6/Vd4zAepvAM0ZlICwPOdcQGBDU3w8stWt8/edeXd65v+on2jmj2a6qHxPXV9tBlJkWOgg6aS6IAIqK0ZQr55IYFO8=
Message-ID: <f36b08ee0610221345m2bb73ae5j1ac46bd4b4638d5f@mail.gmail.com>
Date: Sun, 22 Oct 2006 22:45:22 +0200
From: "Yakov Lerner" <iler.ml@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 'make menuconfig' in Konsole, arrows&backspace do not work ?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In text input field in 'make menuconfig', in xterm, everything works.

But in KDE Konsole: arrows do not work, backspace does not work
in input field, cursor is not visible ( only can append chars to
existing value).

How do I fix this ? $TERM is set to 'xterm'. Vim works perfectly
and has blinking cursor. Do I need different $TERM setting ?

Thanks
Yakov
