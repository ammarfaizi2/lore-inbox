Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWEXBEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWEXBEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 21:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWEXBEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 21:04:47 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:29993 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932401AbWEXBEr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 21:04:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qTG3NbNnGyHiUml6ccZSBj93I2T5l7SeVYlxp8FIdQwnXeuR0xJb5WejTpuTEgYV7kE+rkzMzzNguMfYwBgNF19rgjqFbW+VYUBhq90GnhdVFCiw+LTFebaTQ6b+3XwsS2H5mUTzMrzE6q7RGrgQJ616R/RjJv/Tsy/v0DTESok=
Message-ID: <3faf05680605231804q5aa8d65fqeb02026dd1515876@mail.gmail.com>
Date: Wed, 24 May 2006 06:34:46 +0530
From: "vamsi krishna" <vamsi.krishnak@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Query regarding _etext, _edata, _end.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Are the virtual address's &_etext, &_edata and &_end , always
correspond to END OF TEXT, END OF DATA and END OF BSS ?

If yes , will these be always supported in the newer kernels coming in future?

Thank you,
Vamsi.
