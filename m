Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274603AbRJQEbJ>; Wed, 17 Oct 2001 00:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274611AbRJQEbA>; Wed, 17 Oct 2001 00:31:00 -0400
Received: from ljbc.wa.edu.au ([203.59.143.14]:52475 "HELO gamma.ljbc")
	by vger.kernel.org with SMTP id <S274603AbRJQEaz>;
	Wed, 17 Oct 2001 00:30:55 -0400
Date: Wed, 17 Oct 2001 12:30:49 +0800 (WST)
From: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Turning off faucet. (module)
In-Reply-To: <Pine.LNX.4.33L.0110161957050.6440-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.30.0110171222220.23285-200000@gamma.student.ljbc>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="34210048-1872880043-1003293049=:23285"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--34210048-1872880043-1003293049=:23285
Content-Type: TEXT/PLAIN; charset=US-ASCII


Sorry, I just couldn't resist.

Kernel module that adds the kitchen sick (with water device) to the linux
kernel

Instructions included in source

Beau Kuiper
kuiperba@ljbc.wa.edu.au

On Tue, 16 Oct 2001, Rik van Riel wrote:

> On Tue, 16 Oct 2001, HP LaserJetIII wrote:
>
> > How to turn off faucet?
>
> CONFIG_KITCHENSINK ?
>
> Rik
> --
> DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)
>
> http://www.surriel.com/		http://distro.conectiva.com/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--34210048-1872880043-1003293049=:23285
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="tap.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0110171230490.23285@gamma.student.ljbc>
Content-Description: The kitchen sink device
Content-Disposition: attachment; filename="tap.c"

Ly8gVGFwIG1vZHVsZSwganVzdCBmb3IgZnVuLCBWZXJzaW9uIDAuOQ0KLy8N
Ci8vIFVzYWdlLA0KLy8gQ29tcGlsZSB1c2luZw0KLy8JZ2NjIC1jIHRhcC5j
IC1vIHRhcC5vIC1JL2xpYi9tb2R1bGVzL2B1bmFtZSAtcmAvYnVpbGQvaW5j
bHVkZQ0KLy8NCi8vIFVzZToNCi8vDQovLwlpbnNtb2QgLi90YXAubw0KLy8J
bWtub2QgL2Rldi93YXRlciBjIDIwMCAxDQovLwljYXQgL2Rldi93YXRlcg0K
Ly8NCi8vIFJlbW92YWwNCi8vDQovLwlybSAvZGV2L3dhdGVyDQovLwlybW1v
ZCB0YXANCi8vDQovLyBCZWF1IEt1aXBlciBDb3B5cmlnaHQgKEMpIDIwMDEN
Ci8vIFBhcnRzIGRlcml2ZWQgZnJvbSBkZXZpY2VzL21tL21lbS5jIGZyb20g
bGludXgga2VybmVsDQoNCi8vIExpY2Vuc2VkIHVuZGVyIEdQTCAyLjANCg0K
I2RlZmluZSBNT0RVTEUNCiNkZWZpbmUgX19LRVJORUxfXw0KDQojaW5jbHVk
ZSA8bGludXgvY29uZmlnLmg+DQojaW5jbHVkZSA8bGludXgvdmVyc2lvbi5o
Pg0KI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KI2luY2x1ZGUgPGxpbnV4
L2tlcm5lbC5oPg0KI2luY2x1ZGUgPGxpbnV4L3VuaXN0ZC5oPg0KI2luY2x1
ZGUgPGxpbnV4L3R5cGVzLmg+DQojaW5jbHVkZSA8bGludXgvbWlzY2Rldmlj
ZS5oPg0KI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCiNpbmNsdWRlIDxsaW51
eC9tbS5oPg0KI2luY2x1ZGUgPGxpbnV4L3Jhdy5oPg0KI2luY2x1ZGUgPGxp
bnV4L2ZpbGUuaD4NCiNpbmNsdWRlIDxsaW51eC9lcnJuby5oPg0KDQojaW5j
bHVkZSA8YXNtL2lvLmg+DQojaW5jbHVkZSA8YXNtL3VhY2Nlc3MuaD4NCg0K
ZGV2ZnNfaGFuZGxlX3Qgd2F0ZXJkZXY7DQppbnQgd2F0ZXJfcG9zOw0KDQoj
ZGVmaW5lIFdBVEVSX01BSiAyMDANCiNkZWZpbmUgV0FURVJfTUlOIDENCg0K
c3RhdGljIGxvZmZfdCB3YXRlcl9sc2VlayhzdHJ1Y3QgZmlsZSAqIGZpbGUs
IGxvZmZfdCBvZmZzZXQsIGludCBvcmlnKQ0Kew0KCXJldHVybiBmaWxlLT5m
X3BvcyA9IDA7DQp9DQoNCnN0YXRpYyBzaXplX3Qgd2F0ZXJfcmVhZChzdHJ1
Y3QgZmlsZSAqIGZpbGUsIGNoYXIgKiBidWYsDQoJCQkJc2l6ZV90IGNvdW50
LCBsb2ZmX3QgKnBwb3MpDQp7DQoJdW5zaWduZWQgbG9uZyBsZWZ0LCBwb3M7
DQoJDQoJaWYgKCFhY2Nlc3Nfb2soVkVSSUZZX1dSSVRFLCBidWYsIGNvdW50
KSkNCgkJcmV0dXJuIC1FRkFVTFQ7DQoJDQoJbGVmdCA9IGNvdW50Ow0KCXBv
cyA9IDA7DQoJDQoJd2hpbGUocG9zIDwgY291bnQpDQoJew0KCQlzdHJuY3B5
KGJ1ZiArIHBvcywgIldhdGVyV2F0ZXIiICsgd2F0ZXJfcG9zLCBtaW4obGVm
dCwgKHVuc2lnbmVkIGxvbmcpNSkpOw0KCQlwb3MgKz0gbWluKGxlZnQsICh1
bnNpZ25lZCBsb25nKTUpOw0KCQlsZWZ0IC09IDU7DQoJfQ0KCQ0KCXdhdGVy
X3BvcyArPSBwb3MgJSA1Ow0KCXdhdGVyX3BvcyA9IHdhdGVyX3BvcyAlIDU7
DQoJDQoJcmV0dXJuIGNvdW50Ow0KfQkNCg0Kc3RhdGljIHNpemVfdCB3YXRl
cl93cml0ZShzdHJ1Y3QgZmlsZSAqIGZpbGUsIGNoYXIgKiBidWYsDQoJCQkJ
c2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpDQp7DQoJcmV0dXJuIC1FSU5W
QUw7DQp9DQoNCnN0YXRpYyBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIHdhdGVy
X2ZvcHMgPSB7DQoJbGxzZWVrOgkJd2F0ZXJfbHNlZWssDQoJcmVhZDoJCXdh
dGVyX3JlYWQsDQoJd3JpdGU6CQl3YXRlcl93cml0ZSwNCn07DQoNCnN0YXRp
YyBpbnQgd2F0ZXJfb3BlbihzdHJ1Y3QgaW5vZGUgKiBpbm9kZSwgc3RydWN0
IGZpbGUgKiBmaWxwKQ0Kew0KCXN3aXRjaCAoTUlOT1IoaW5vZGUtPmlfcmRl
dikpIA0KCXsNCgkJY2FzZSBXQVRFUl9NSU46DQoJCQlmaWxwLT5mX29wID0g
JndhdGVyX2ZvcHM7DQoJCQlicmVhazsNCgkJZGVmYXVsdDoNCgkJCXJldHVy
biAtRU5YSU87DQoJfQ0KCXJldHVybigwKTsNCn0NCg0Kc3RhdGljIHN0cnVj
dCBmaWxlX29wZXJhdGlvbnMgd2F0ZXJfbWV0YV9mb3BzID0gew0KCW9wZW46
CQl3YXRlcl9vcGVuLA0KfTsNCg0KaW50IGluaXRfbW9kdWxlKHZvaWQpIA0K
ew0KDQoJaWYgKGRldmZzX3JlZ2lzdGVyX2NocmRldihXQVRFUl9NQUogLCJ0
YXAiLCZ3YXRlcl9tZXRhX2ZvcHMpKQ0KCXsNCgkJcHJpbnRrKCJ1bmFibGUg
dG8gZ2V0IG1ham9yICVkIGZvciBtZW1vcnkgZGV2c1xuIiwgV0FURVJfTUFK
KTsNCgkJcmV0dXJuIC0xOw0KCX0NCgkNCgl3YXRlcmRldiA9IGRldmZzX3Jl
Z2lzdGVyKE5VTEwsICJ3YXRlciIsIERFVkZTX0ZMX05PTkUsIA0KCQkJCQkJ
IFdBVEVSX01BSiwgV0FURVJfTUlOLA0KCQkJCQkJIFNfSVJVR08gfCBTX0lX
VUdPIHwgU19JRkNIUiwNCgkJCQkJCSAmd2F0ZXJfZm9wcywgTlVMTCk7DQoJ
d2F0ZXJfcG9zID0gMDsNCglyZXR1cm4gMDsNCn0NCg0Kdm9pZCBjbGVhbnVw
X21vZHVsZSh2b2lkKQ0Kew0KCWRldmZzX3VucmVnaXN0ZXJfY2hyZGV2KFdB
VEVSX01BSiwgInRhcCIpOw0KCWRldmZzX3VucmVnaXN0ZXIod2F0ZXJkZXYp
Ow0KfQ0K
--34210048-1872880043-1003293049=:23285--
