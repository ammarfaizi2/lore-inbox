Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269350AbRHQOtd>; Fri, 17 Aug 2001 10:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271650AbRHQOtX>; Fri, 17 Aug 2001 10:49:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30990 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269350AbRHQOtM>; Fri, 17 Aug 2001 10:49:12 -0400
Subject: Re: Kernel panic problem in 2.4.7
To: antihong@tt.co.kr (=?ks_c_5601-1987?B?v8C0w7D6s7vAzyDIq7yuufw=?=)
Date: Fri, 17 Aug 2001 15:51:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "=?ks_c_5601-1987?B?v8C0w7D6s7vAzyDIq7yuufw=?=" at Aug 17, 2001 11:36:35 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XkyT-0007Sf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> SGVsbG8uLiBBbGwNCg0KSSBoYXZlIG9wZXJhdGVkIFJlZGhhdCA2LjIgYmFzZWQgc3lzdGVtKGtl
> cm5lbCAyLjQuNykgIHdoaWNoIGlzIER1YWwgQ1BVIGFuZCA1MTJNIFJhbS4NCg0KQSBmZXcgZGF5
> cyBhZ28sIHRoaXMgc3lzdGVtIGlzIGRvd24gYW5kIHRoZSBtZXNzYWdlcyBsaWtlIGJlbG93Lg0K
> DQpKdWwgMjIgMTQ6NTc6NDUgd3d3IGtlcm5lbDogS2VybmVsIHBhbmljOiBDUFUgY29udGV4dCBj
> b3JydXB0DQpKdWwgMjUgMTk6MjU6MzAgd3d3IGtlcm5lbDogS2VybmVsIHBhbmljOiBDUFUgY29u
> dGV4dCBjb3JydXB0DQpKdWwgMjcgMjM6NDM6MjIgd3d3IGtlcm5lbDogS2VybmVsIHBhbmljOiBD
> UFUgY29udGV4dCBjb3JydXB0DQoNCnRoaXMgbWFpbGxpbmcgbGlzdCBzYXkgdGhhdCB0aGlzIGlz
> IENQVSBQcm9ibGVtKG92ZXJjbG9ja2luZy4uLi5idXQgaXQgaXNuJ3QpLg0KU28gSSBjaGFuZ2Vk
> IG90aGVyIENQVXMgdGhhdCBJIHRoaW5rICBubyBwcm9ibGVtLg0KDQpCdXQgYSBmZXcgZGF5cyBs
> YXRlci4ga2VybmVsIHBhbmljIG9jY3VyZWQgYWdhaW4uDQooVGhlIHN5c3RlbSBpcyAyLjQuNykN
> CnRoZSBtZXNzYWdlcyB3YXMgDQoNCktlcm5lbCBwYW5pYzpBaWVlLCBraWxsaW5nIGludGVycnVw
> dCBoYW5kbGVyDQpJbiBpbnRlcnJ1cHQgaGFuZGxlciAtIG5vdCBzeW5jaW5nDQoNClRoaXMgbWVz
> c2FnZSBpcyBvY2N1cmVkIHdoZW4gdGhlIHN5c3RlbSdzIGxvYWQgYXZlcmFnZSBpcyBhIGJpdCBo
> aWdoLg0KKFdoZW4gSSBLZXJuZWwgY29tcGlsZSBvciBwYWNraW5nIHdpdGggdGFyLi4gc29tdGhp
> bmcgbGlrZSB0aGF0Li4pDQoNCkkgc2VhcmNoZWQgYWxsIGxpc3RzLCBCdXQgSSBjb3VsZG4ndCBm
> aW5kIHRoZSAicmVhc29uIiBhbmQgImFuc3dlciIuDQpJIHdvdWxkIGxpa2UgdG8ga25vdyB0aGUg
> cmVhc29uIGFuZCBhbnN3ZXIuDQoNClBsZWFzZSBnaXZlIG1lIHNvbWUgYWR2aWNlIGFib3V0IHRo
> ZXNlIHByb2JsZW1zLg0KDQogDQogVGhhbmtzIGZvciB5b3VyIGhlbHAuDQogIA0KIA0K
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

