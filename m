Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWILKfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWILKfB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 06:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWILKfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 06:35:01 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:55222 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965161AbWILKV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 06:21:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=QfR+wYhij++BBR2shE9Uiy0HM3RR1vQ4FtncjBtdEnyf1ruYaqCw6WfKH5dYQ/jlrjNwGvmsB9uV7emrsvr964fB7QZIh5+kJTf+dWmrBbjQxoSPnM+pnYl/dWAwEaVucL9eHDqsCIaQWpkWLAKpzh6Sm3tYWUB9IZAhMiZptEQ=
Message-ID: <6c99578d0609120321h461e18c1tc50e06ec7cd43619@mail.gmail.com>
Date: Tue, 12 Sep 2006 11:21:57 +0100
From: "=?ISO-8859-2?Q?Marcin_Pr=B1czko?=" <marcin.praczko@googlemail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel Oops
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_110719_8257713.1158056517664"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_110719_8257713.1158056517664
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I compiled kernel 2.6.17.7 - all is build in kernel (no modules)
And yesterday I had Oops:
I enclosed Oops info.

Can you explain to me please, where is some problem ??

------=_Part_110719_8257713.1158056517664
Content-Type: application/octet-stream; name=007_kernel_panic000
Content-Transfer-Encoding: base64
X-Attachment-Id: f_es0544m5
Content-Disposition: attachment; filename="007_kernel_panic000"

W0tFUk5FTCBQQU5JQ10uLi4gCgoxMi4wOC4yMDA2IAprZXJuZWwgMi42LjE3LjcKaTU4NgoKQlVH
OiB1bmFibGUgdG8gaGFuZGxla2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRyZXNz
IDA0MDAwMDIwCiAgcHJpbnRpbmcgZWlwOgpjMDI0YzNkNQoqcGRlID0gMDAwMDAwMDAKT29wczog
MDAwMCBbIzFdCk1vZHVsZXMgbGlua2VkIGluOgpDUFU6ICAgICAwCkVJUDogICAgIDAwNjA6Wzxj
MDI0YzNkNT5dICBOb3QgdGFpbnRlZCBWTEkKRUZMQUdTOiAgMDAwMTAyMDYgICgyLjYuMTcuNyAj
MykKRUlQOiBpcyBhdCBydF9jaGVja19leHBpcmUrMHg5YS8weDEwYwplYXg6IDA0MDAwMDAwICBl
Yng6IDA0MDAwMDAwICBlY3g6IDAwMDAwMDAwICBlZHg6IDAwMDAwMDU1CmVzaTogZjdjYTAxNTQg
IGVkaTogMDAwMTI0ZjggIGVicDogMDAwMDE4OTEgIGVzcDogYzAzNDNmNjAKZHM6IDAwN2IgIGVz
OiAwMDdiICBzczogMDA2OApQcm9jZXNzIHN3YXBwZXIgKHBpZDogMCwgdGhyZWFkaW5mbz1jMDM0
MjAwMCB0YXNrPWMwMmViMTgwKQpTdGFjazogMDA0M2NlYTMgMDAwMDAwNTUgMDAwMDAwMGEgYzAz
NDIwMDAgYzAzNzkxZTAgMDAwMDAxMDAgYzAyNGMzM2IgYzAxMTljN2QKICAgICAgIGMwMzkwMDM0
IGMwMzkwMDM0IGMwMTI3Y2U4IDAwMDAwMDAxIGMwMzc4ZWU4IDAwMDAwMDBhIDAwM2I5MDA3IGMw
MTE2ZTY5CiAgICAgICAwMDAwMDA0NiAwMDA5ZmIwMCBjMDMzNzgwMCBjMDExNmVkMyAwMDAxMDgw
MCBjMDEwNDhkZSBjMDEwMzM3YSAwMDAxMDgwMApDYWxsIFRyYWNlOgogPGMwMjRjMzNiPiBydF9j
aGVja19leHBpcmUrMHgwLzB4MTBjICA8YzAxMTljN2Q+IHJ1bl90aW1lcl9zb2Z0aXJxKzB4MzUv
MHg3ZAogPGMwMTI3Y2U4PiBoYW5kbGVfSVJRX2V2ZW50KzB4MjEvMHg0YSAgPGMwMTE2ZTY5PiBf
X2RvX3NvZnRpcnErMHgzNS8weDdkCiA8YzAxMTZlZDM+IGRvX3NvZnRpcnErMHgyMi8weDI2ICA8
YzAxMDQ4ZGU+IGRvX0lSUSsweDFlLzB4MjQKIDxjMDEwMzM3YT4gY29tbW9uX2ludGVycnVwdCsw
eDFhLzB4MjAgIDxjMDEwMGE3Mz4gZGVmYXVsdF9pZGxlKzB4MmIvMHg1MwogPGMwMTAwYWYxPiBj
cHVfaWRsZSsweDQyLzB4NTcgIDxjMDM0NDVlYT4gc3RhcnRfa2VybmVsKzB4MTcwLzB4MTcyCkNv
ZGU6IGVkIDc0IDczIGZmIDQ0IDI0IDA0IDhiIDE1IDA4IDFmIDM5IGMwIDIxIDU0IDI0IDA0IGEx
IDA0IDFmIDM5IGMwIDhiIDU0IDI0IDA0IDhiIDNkIDg4IGQzIDMwIGMwIDhkIDM0IDkwIDhiIDA2
IDg1IGMwIDc0IDRhCiA4OSBjMyA8OGI+IDQzIDIwIDg1IGMwIDc0IDA3IDNiIDA0IDI0IDc4IDFi
IGViIDEzIDhiIDBkIDg4IGQzIDMwIGMwIDg5CkVJUDogWzxjMDI0YzNkNT5dIHJ0X2NoZWNrX2V4
cGlyZSsweDlhLzB4MTBjIFNTOkVTUCAwMDY4OmMwMzQzZjYwCiA8MD5LZXJuZWwgcGFuaWMgLSBu
b3Qgc3luY2luZzogRmF0YWwgZXhjZXB0aW9uIGluIGludGVycnVwdCAKCg==
------=_Part_110719_8257713.1158056517664--
