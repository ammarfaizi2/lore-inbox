Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVCNWTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVCNWTA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVCNWKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:10:14 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:19346 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP id S261967AbVCNWFu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:05:50 -0500
Date: Mon, 14 Mar 2005 23:05:40 +0100
Message-Id: <833993817@web.de>
MIME-Version: 1.0
From: "Enrico Bartky" <DOSProfi@web.de>
To: linux-kernel@vger.kernel.org
Subject: SMbus not enabled
Organization: http://freemail.web.de/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

my notebook have a SiS 964 Chipset and "quirked" by "quirk_sis_503", ... but there is no SMbus device. If I add a call to the "quirk_sis_96x_smbus" function directly from the "quirk_sis_503" function, the smbus is present, but I think a call to a quirk from a quirk is not optimal. Is there a better solution?

EnricoB
__________________________________________________________
Mit WEB.DE FreePhone mit hoechster Qualitaet ab 0 Ct./Min.
weltweit telefonieren! http://freephone.web.de/?mc=021201

