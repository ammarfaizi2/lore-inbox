Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbRF1RMP>; Thu, 28 Jun 2001 13:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266038AbRF1RMF>; Thu, 28 Jun 2001 13:12:05 -0400
Received: from spc.esa.lanl.gov ([128.165.46.232]:11392 "HELO spc.esa.lanl.gov")
	by vger.kernel.org with SMTP id <S266039AbRF1RL4>;
	Thu, 28 Jun 2001 13:11:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-ac20 five more undocumented symbols
Date: Thu, 28 Jun 2001 11:09:05 -0600
X-Mailer: KMail [version 1.2]
Cc: dwmw2@infradead.org, esr@thyrsus.com
MIME-Version: 1.0
Message-Id: <01062811090501.01130@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

In addition to the 14 new CONFIG symbols without help texts which
2.4.6-pre6 introduced, 2.4.5-ac20 has 5 more, for a total of 19 in -ac20.

Here are the five new symbols in 2.4.5-ac20 which don't have
Configure.help texts and likely should have. If you're the owner
of these, please provide the appropriate help texts for Configure.help.

Or, if they don't need no steenking help texts, please let ESR and me
know that too.

Thanks in advance,
Steven

CONFIG_FB_ATY_CT_VAIO_LCD
CONFIG_MTD_CFI_BE_BYTE_SWAP
CONFIG_MTD_CFI_LART_BIT_SWAP
CONFIG_MTD_CFI_LE_BYTE_SWAP
CONFIG_MTD_CFI_VIRTUAL_ER
