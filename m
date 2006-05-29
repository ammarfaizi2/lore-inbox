Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWE2PWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWE2PWv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 11:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWE2PWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 11:22:51 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:44425 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751032AbWE2PWv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 11:22:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Dcp+3qT5mvBvNvby/1urc1XyWhdr601iUfaPV8/VVrzMAO4VWJszc0hsQKS/xwQrYbvkQJLTltt0+S1cCS+gwikuOyriZjjAEG3efUR9CJt8zVF66hrIRp1RZQluxf8znxBnfM17JREeDrho/Z0M6xLeTQpih2Q1OPDqLwUg3/g=
Message-ID: <ceccffee0605290822m6e81c981u4d120ffa8388ee63@mail.gmail.com>
Date: Mon, 29 May 2006 17:22:50 +0200
From: "Linux Portal" <linportal@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: The adaptive readahead patch benchmark
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is an interesting (although simple) benchmark of Wu's adaptive
readahead patchset (v12) together with graphs here:

  http://linux.inet.hr/adaptive_readahead_benchmark.html

In that simple test it definitely looks promising (3x speedup).
