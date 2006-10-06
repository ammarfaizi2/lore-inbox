Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWJFJuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWJFJuk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 05:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWJFJuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 05:50:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:44138 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751397AbWJFJuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 05:50:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=WFdKZBQJupolOdzWGyZeBWlx/Z6pXsE27LC9jOFZxo6shCGC+Y47ZIukTzwXODSeFoJoujMnnYHMx6LDSrYHrSxoashg+eMNpgLj0ht9yrGm/kJ9QfKGrccmgut3HoY1lixVkJhWqp3WghScmw5+0lsxOn3uTo92APRlL6oYmTg=
Message-ID: <cc723f590610060250n142f0d85t383ab888bd48dc43@mail.gmail.com>
Date: Fri, 6 Oct 2006 15:20:37 +0530
From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix typos in mm/shmem_acl.c
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_30811_1282335.1160128237525"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_30811_1282335.1160128237525
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



------=_Part_30811_1282335.1160128237525
Content-Type: text/x-patch; name="shmem_acl.c.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="shmem_acl.c.diff"
X-Attachment-Id: f_esyee6vk

ZGlmZiAtLWdpdCBhL21tL3NobWVtX2FjbC5jIGIvbW0vc2htZW1fYWNsLmMKaW5kZXggYzk0NmJm
NC4uZjU2NjRjNSAxMDA2NDQKLS0tIGEvbW0vc2htZW1fYWNsLmMKKysrIGIvbW0vc2htZW1fYWNs
LmMKQEAgLTM1LDcgKzM1LDcgQEAgc2htZW1fZ2V0X2FjbChzdHJ1Y3QgaW5vZGUgKmlub2RlLCBp
bnQgdAogfQogCiAvKioKLSAqIHNobWVtX2dldF9hY2wgIC0gICBnZW5lcmljX2FjbF9vcGVyYXRp
b25zLT5zZXRhY2woKSBvcGVyYXRpb24KKyAqIHNobWVtX3NldF9hY2wgIC0gICBnZW5lcmljX2Fj
bF9vcGVyYXRpb25zLT5zZXRhY2woKSBvcGVyYXRpb24KICAqLwogc3RhdGljIHZvaWQKIHNobWVt
X3NldF9hY2woc3RydWN0IGlub2RlICppbm9kZSwgaW50IHR5cGUsIHN0cnVjdCBwb3NpeF9hY2wg
KmFjbCkK
------=_Part_30811_1282335.1160128237525--
