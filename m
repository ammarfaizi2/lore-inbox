Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755139AbWKZXWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139AbWKZXWN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 18:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755091AbWKZXWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 18:22:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:18993 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1755138AbWKZXWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 18:22:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:x-google-sender-auth;
        b=WJnZOOy3ZfrIKc9DWiM6LhVEswWf9/22thSrJOsZn8IYXUKsRt8ZUfJ4aNr9FmEVZruPD6+KSk50zO5+LBR73Z6iD7AVMhrVZpKpQ0xrXX7dnX3toWE67gUv8e/KSBipHWDW4LjVLHo7vRtlqOlZObT6mwfohfERVJdRXBr4Bqw=
Message-ID: <86802c440611261522x5427ab2et8602f1275222a8d0@mail.gmail.com>
Date: Sun, 26 Nov 2006 15:22:10 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 1/3] x86_64: remove unused acpi_found_madt in mparse.
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_60577_26283494.1164583330582"
X-Google-Sender-Auth: 34194d22a0dee84d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_60577_26283494.1164583330582
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



------=_Part_60577_26283494.1164583330582
Content-Type: text/x-patch; name=ai_1.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ev02sgom
Content-Disposition: attachment; filename="ai_1.diff"

W1BBVENIIDEvM10geDg2XzY0OiByZW1vdmUgdW51c2VkIGFjcGlfZm91bmRfbWFkdCBpbiBtcGFy
c2UuCgpyZW1vdmUgdW51c2VkIGFjcGlfZm91bmRfbWFkdCBpbiBtcGFyc2UuYwoKU2lnbmVkLW9m
Zi1ieTogWWluZ2hhaSBMdSA8eWluZ2hhaS5sdUBhbWQuY29tPgoKZGlmZiAtLWdpdCBhL2FyY2gv
eDg2XzY0L2tlcm5lbC9tcHBhcnNlLmMgYi9hcmNoL3g4Nl82NC9rZXJuZWwvbXBwYXJzZS5jCmlu
ZGV4IGIxNDdhYjEuLjA4MDcyNTYgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2XzY0L2tlcm5lbC9tcHBh
cnNlLmMKKysrIGIvYXJjaC94ODZfNjQva2VybmVsL21wcGFyc2UuYwpAQCAtMzUsOCArMzUsNiBA
QAogaW50IHNtcF9mb3VuZF9jb25maWc7CiB1bnNpZ25lZCBpbnQgX19pbml0ZGF0YSBtYXhjcHVz
ID0gTlJfQ1BVUzsKIAotaW50IGFjcGlfZm91bmRfbWFkdDsKLQogLyoKICAqIFZhcmlvdXMgTGlu
dXgtaW50ZXJuYWwgZGF0YSBzdHJ1Y3R1cmVzIGNyZWF0ZWQgZnJvbSB0aGUKICAqIE1QLXRhYmxl
Lgo=
------=_Part_60577_26283494.1164583330582--
