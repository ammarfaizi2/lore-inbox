Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264888AbTFLQTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbTFLQSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:18:44 -0400
Received: from tao.natur.cuni.cz ([195.113.56.1]:60936 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S264884AbTFLQSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:18:33 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Date: Thu, 12 Jun 2003 18:32:18 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Linux Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.21-rc7 ACPI broken
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96F22@orsmsx401.jf.intel.com>
Message-ID: <Pine.OSF.4.51.0306121825500.300337@tao.natur.cuni.cz>
References: <F760B14C9561B941B89469F59BA3A847E96F22@orsmsx401.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jun 2003, Grover, Andrew wrote:

> > From: Martin MOKREJ© [mailto:mmokrejs@natur.cuni.cz]
> > ACPI: Core Subsystem version [20011018]
>
> Old ACPI code, get patch from http://sf.net/projects/acpi and report back if problems persist.

Hi,
  so I retried the latest patch available from sourceforge site, but that
is for pre-2.4.21-rc3 candidate. Even worse, some parsed applied with
offset and in one or two cases got rejected! So I have to wait if patch for
-rc8 appears or for anything newer. Anyone successfully applied
acpi-20030523-2.4.21-rc3.diff.gz 7b9551e86393a58d8e6c2b3aeeea2f16
(md5sum)?

Thanks
-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585
