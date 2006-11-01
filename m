Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992792AbWKATzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992792AbWKATzt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 14:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992793AbWKATzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 14:55:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:38774 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S2992792AbWKATzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 14:55:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mYCJd1Qxo8A0o0TzzntNwDln5qTBf0NzThLTQcmh4wiLnBiEWAqfxCOnusWEMbSfTo2CCmq28xM02VH9/q3enaOX73qlEHKSGO9AQzhncUozhrle+G2aHkMmS2tWvwpuPX5AoxHlS4CvBKA7GNURRWcL2jWUr5StmihdTFRrPk8=
Message-ID: <2aac3c260611011155o7c7ad52btc869405af1c00f96@mail.gmail.com>
Date: Wed, 1 Nov 2006 20:55:41 +0100
From: "Giangiacomo Mariotti" <giangiacomo.mariotti@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]cleaning of the definition of HANDLE_STACK
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was not a compilation warning,but a prolem found with sparse.
