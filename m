Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbWJJILg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWJJILg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 04:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbWJJILf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 04:11:35 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:20162 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965095AbWJJILd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 04:11:33 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: "Noguchi, Masato" <Masato.Noguchi@jp.sony.com>
Subject: Re: [Cbe-oss-dev] [PATCH 09/14] spufs: add support for read/write oncntl
Date: Tue, 10 Oct 2006 10:11:25 +0200
User-Agent: KMail/1.9.4
Cc: "Paul Mackerras" <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <C3DCD550FB9ACD4D911D1271DD8CFDD20113D3D7@jptkyxms38.jp.sony.com>
In-Reply-To: <C3DCD550FB9ACD4D911D1271DD8CFDD20113D3D7@jptkyxms38.jp.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610101011.27949.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 October 2006 08:00, Noguchi, Masato wrote:
> After applying these patches, it seems the kernel leaks memory.
> No doubt you forget to call simple_attr_close on "[PATCH 09/14]
> spufs: add support for read/write oncntl".

Ok, thanks for pointing this out.
 
> Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Paul, please apply.

	Arnd <><
